/**
 * The custom logic attached to the Purchases entity to perform calculations after reading the purchase data, ensuring the reward points and total values are correctly reflected.
 * @After(event = { "READ" }, entity = "full_Stack_cdsSrv.Purchases")
 * @param {(Object|Object[])} results - For the After phase only: the results of the event processing
 * @param {cds.Request} request - User information, tenant-specific CDS model, headers and query parameters
 */
module.exports = async function(results, request) {
  const { Customers } = cds.entities;

  if (!results) return;

  // Ensure results is an array for consistent processing
  const purchases = Array.isArray(results) ? results : [results];

  for (const purchase of purchases) {
    if (!purchase.customer_ID) continue;

    // Fetch the customer details
    const customer = await SELECT.one.from(Customers).where({ ID: purchase.customer_ID });

    if (customer) {
      // Calculate the new total purchase value and reward points
      const newTotalPurchaseValue = (customer.totalPurchaseValue || 0) + (purchase.purchaseValue || 0);
      const newTotalRewardPoints = (customer.totalRewardPoints || 0) + (purchase.rewardPoints || 0);

      // Update the customer entity with new calculated values
      await UPDATE(Customers).set({
        totalPurchaseValue: newTotalPurchaseValue,
        totalRewardPoints: newTotalRewardPoints
      }).where({ ID: purchase.customer_ID });
    }
  }
};
