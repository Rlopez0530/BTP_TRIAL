/**
 * The custom logic attached to the Redemptions entity to deduct the redemption amount from the customer's total reward points and add it to their total redeemed points.
 * @Before(event = { "CREATE", "UPDATE" }, entity = "full_Stack_cdsSrv.Redemptions")
 * @param {cds.Request} request - User information, tenant-specific CDS model, headers and query parameters
 */
module.exports = async function(request) {
  const { Redemptions, Customers } = cds.entities;

  // Extract the redemption details from the request data
  const { customer_ID, redeemedAmount } = request.data;

  // Ensure the customer_ID and redeemedAmount are defined
  if (!customer_ID || redeemedAmount === undefined) {
    return;
  }

  // Fetch the customer record
  const customer = await SELECT.one.from(Customers).where({ ID: customer_ID });

  // Ensure the customer exists
  if (!customer) {
    return;
  }

  // Calculate the new total reward points and total redeemed reward points
  const newTotalRewardPoints = customer.totalRewardPoints - redeemedAmount;
  const newTotalRedeemedRewardPoints = customer.totalRedeemedRewardPoints + redeemedAmount;

  // Update the customer's total reward points and total redeemed reward points
  await UPDATE(Customers)
    .set({
      totalRewardPoints: newTotalRewardPoints,
      totalRedeemedRewardPoints: newTotalRedeemedRewardPoints
    })
    .where({ ID: customer_ID });
};
