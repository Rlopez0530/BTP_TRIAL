/**
 * The custom logic attached to the Redemptions entity to ensure the redemption data is correctly reflected after reading.
 * @After(event = { "READ" }, entity = "full_Stack_cdsSrv.Redemptions")
 * @param {(Object|Object[])} results - For the After phase only: the results of the event processing
 * @param {cds.Request} request - User information, tenant-specific CDS model, headers and query parameters
 */
module.exports = async function(results, request) {
  const { Customers } = cds.entities;

  // Ensure results is an array
  if (!Array.isArray(results)) {
    results = [results];
  }

  // Iterate over each redemption result
  for (const redemption of results) {
    if (redemption && redemption.customer_ID) {
      // Calculate the total redeemed reward points for the customer
      const { totalRedeemedRewardPoints } = await SELECT.one.from(Customers)
        .columns('totalRedeemedRewardPoints')
        .where({ ID: redemption.customer_ID });

      // If the customer exists, update the total redeemed reward points
      if (totalRedeemedRewardPoints !== undefined) {
        await UPDATE(Customers).set({
          totalRedeemedRewardPoints: totalRedeemedRewardPoints + redemption.redeemedAmount
        }).where({ ID: redemption.customer_ID });
      }
    }
  }
};
