using { full_Stack_cdsSrv } from '../srv/service.cds';

annotate full_Stack_cdsSrv.Customers with @UI.HeaderInfo: { TypeName: 'Customer', TypeNamePlural: 'Customers', Title: { Value: customerNumber } };
annotate full_Stack_cdsSrv.Customers with {
  ID @UI.Hidden @Common.Text: { $value: customerNumber, ![@UI.TextArrangement]: #TextOnly }
};
annotate full_Stack_cdsSrv.Customers with @UI.Identification: [{ Value: customerNumber }];
annotate full_Stack_cdsSrv.Customers with {
  email @title: 'Email';
  customerNumber @title: 'Customer Number';
  totalPurchaseValue @title: 'Total Purchase Value';
  totalRewardPoints @title: 'Total Reward Points';
  totalRedeemedRewardPoints @title: 'Total Redeemed Reward Points'
};

annotate full_Stack_cdsSrv.Customers with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: email },
 { $Type: 'UI.DataField', Value: customerNumber },
 { $Type: 'UI.DataField', Value: totalPurchaseValue },
 { $Type: 'UI.DataField', Value: totalRewardPoints },
 { $Type: 'UI.DataField', Value: totalRedeemedRewardPoints }
];

annotate full_Stack_cdsSrv.Customers with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: email },
 { $Type: 'UI.DataField', Value: customerNumber },
 { $Type: 'UI.DataField', Value: totalPurchaseValue },
 { $Type: 'UI.DataField', Value: totalRewardPoints },
 { $Type: 'UI.DataField', Value: totalRedeemedRewardPoints }
  ]
};

annotate full_Stack_cdsSrv.Customers with {
  purchases @Common.Label: 'Purchases';
  redemptions @Common.Label: 'Redemptions'
};

annotate full_Stack_cdsSrv.Customers with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate full_Stack_cdsSrv.Customers with @UI.SelectionFields: [
  customerNumber
];

annotate full_Stack_cdsSrv.Products with @UI.HeaderInfo: { TypeName: 'Product', TypeNamePlural: 'Products', Title: { Value: name } };
annotate full_Stack_cdsSrv.Products with {
  ID @UI.Hidden @Common.Text: { $value: name, ![@UI.TextArrangement]: #TextOnly }
};
annotate full_Stack_cdsSrv.Products with @UI.Identification: [{ Value: name }];
annotate full_Stack_cdsSrv.Products with {
  name @title: 'Name';
  description @title: 'Description';
  price @title: 'Price'
};

annotate full_Stack_cdsSrv.Products with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: name },
 { $Type: 'UI.DataField', Value: description },
 { $Type: 'UI.DataField', Value: price }
];

annotate full_Stack_cdsSrv.Products with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: name },
 { $Type: 'UI.DataField', Value: description },
 { $Type: 'UI.DataField', Value: price }
  ]
};

annotate full_Stack_cdsSrv.Products with {
  purchases @Common.Label: 'Purchases'
};

annotate full_Stack_cdsSrv.Products with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate full_Stack_cdsSrv.Products with @UI.SelectionFields: [
  name
];

annotate full_Stack_cdsSrv.Purchases with @UI.HeaderInfo: { TypeName: 'Purchase', TypeNamePlural: 'Purchases' };
annotate full_Stack_cdsSrv.Purchases with {
  customer @Common.ValueList: {
    CollectionPath: 'Customers',
    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: customer_ID, 
        ValueListProperty: 'ID'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'name'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'email'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'customerNumber'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'totalPurchaseValue'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'totalRewardPoints'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'totalRedeemedRewardPoints'
      },
    ],
  }
};
annotate full_Stack_cdsSrv.Purchases with {
  selectedProduct @Common.ValueList: {
    CollectionPath: 'Products',
    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: selectedProduct_ID, 
        ValueListProperty: 'ID'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'name'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'description'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'price'
      },
    ],
  }
};
annotate full_Stack_cdsSrv.Purchases with {
  purchaseValue @title: 'Purchase Value';
  rewardPoints @title: 'Reward Points'
};

annotate full_Stack_cdsSrv.Purchases with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: purchaseValue },
 { $Type: 'UI.DataField', Value: rewardPoints },
    { $Type: 'UI.DataField', Label: 'Customer', Value: customer_ID },
    { $Type: 'UI.DataField', Label: 'Selected Product', Value: selectedProduct_ID }
];

annotate full_Stack_cdsSrv.Purchases with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: purchaseValue },
 { $Type: 'UI.DataField', Value: rewardPoints },
    { $Type: 'UI.DataField', Label: 'Customer', Value: customer_ID },
    { $Type: 'UI.DataField', Label: 'Selected Product', Value: selectedProduct_ID }
  ]
};

annotate full_Stack_cdsSrv.Purchases with {
  customer @Common.Text: { $value: customer.customerNumber, ![@UI.TextArrangement]: #TextOnly };
  selectedProduct @Common.Text: { $value: selectedProduct.name, ![@UI.TextArrangement]: #TextOnly }
};

annotate full_Stack_cdsSrv.Purchases with {
  customer @Common.Label: 'Customer';
  selectedProduct @Common.Label: 'Selected Product'
};

annotate full_Stack_cdsSrv.Purchases with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate full_Stack_cdsSrv.Purchases with @UI.SelectionFields: [
  customer_ID,
  selectedProduct_ID
];

annotate full_Stack_cdsSrv.Redemptions with @UI.HeaderInfo: { TypeName: 'Redemption', TypeNamePlural: 'Redemptions' };
annotate full_Stack_cdsSrv.Redemptions with {
  customer @Common.ValueList: {
    CollectionPath: 'Customers',
    Parameters    : [
      {
        $Type            : 'Common.ValueListParameterInOut',
        LocalDataProperty: customer_ID, 
        ValueListProperty: 'ID'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'name'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'email'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'customerNumber'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'totalPurchaseValue'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'totalRewardPoints'
      },
      {
        $Type            : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'totalRedeemedRewardPoints'
      },
    ],
  }
};
annotate full_Stack_cdsSrv.Redemptions with {
  redeemedAmount @title: 'Redeemed Amount'
};

annotate full_Stack_cdsSrv.Redemptions with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: redeemedAmount },
    { $Type: 'UI.DataField', Label: 'Customer', Value: customer_ID }
];

annotate full_Stack_cdsSrv.Redemptions with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: redeemedAmount },
    { $Type: 'UI.DataField', Label: 'Customer', Value: customer_ID }
  ]
};

annotate full_Stack_cdsSrv.Redemptions with {
  customer @Common.Text: { $value: customer.customerNumber, ![@UI.TextArrangement]: #TextOnly }
};

annotate full_Stack_cdsSrv.Redemptions with {
  customer @Common.Label: 'Customer'
};

annotate full_Stack_cdsSrv.Redemptions with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate full_Stack_cdsSrv.Redemptions with @UI.SelectionFields: [
  customer_ID
];

