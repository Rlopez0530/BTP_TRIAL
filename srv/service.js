/**
 * Code is auto-generated by Application Logic, DO NOT EDIT.
 * @version(2.0)
 */
const LCAPApplicationService = require('@sap/low-code-event-handler');
const before_Purchases_Create_Update = require('./code/before-purchases-create-update');
const after_Purchases_Read = require('./code/after-purchases-read');
const before_Redemptions_Create_Update = require('./code/before-redemptions-create-update');
const after_Redemptions_Read = require('./code/after-redemptions-read');

class full_Stack_cdsSrv extends LCAPApplicationService {
    async init() {

        this.before(['CREATE', 'UPDATE'], 'Purchases', async (request) => {
            await before_Purchases_Create_Update(request);
        });

        this.after('READ', 'Purchases', async (results, request) => {
            await after_Purchases_Read(results, request);
        });

        this.before(['CREATE', 'UPDATE'], 'Redemptions', async (request) => {
            await before_Redemptions_Create_Update(request);
        });

        this.after('READ', 'Redemptions', async (results, request) => {
            await after_Redemptions_Read(results, request);
        });

        return super.init();
    }
}


module.exports = {
    full_Stack_cdsSrv
};