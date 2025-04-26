/**
 * The custom logic attached to the Purchases entity to calculate reward points as one tenth of the purchase value and update the total purchase value of the related customer.
 * @Before(event = { "CREATE","UPDATE" }, entity = "full_Stack_cdsSrv.Purchases")
 * @param {cds.Request} request - User information, tenant-specific CDS model, headers and query parameters
 */
module.exports = async function(request) {
    const { Customers } = cds.entities;

    // Extract the data from the request
    const { data } = request;

    // Calculate reward points as one tenth of the purchase value
    if (data.purchaseValue !== undefined) {
        data.rewardPoints = Math.floor(data.purchaseValue / 10);
    }

    // Update the total purchase value of the related customer
    if (data.customer_ID) {
        const customer = await SELECT.one.from(Customers).where({ ID: data.customer_ID });

        if (customer) {
            const newTotalPurchaseValue = (customer.totalPurchaseValue || 0) + (data.purchaseValue || 0);
            await UPDATE(Customers).set({ totalPurchaseValue: newTotalPurchaseValue }).where({ ID: data.customer_ID });
        }
    }
}
