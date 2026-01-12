@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Test'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZCL_TEST as select from I_PurchaseOrderAPI01
{
    key PurchaseOrder,
    PurchaseOrderType
   
}
