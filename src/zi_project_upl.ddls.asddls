@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface for project upload'
@Metadata.ignorePropagatedAnnotations: true
define   root view entity Zi_Project_Upl as select from zdb_projupload
{
    key project_element as ProjectElement,
    wbselement_id as WbselementId,
    project_id as ProjectId,
    project_element_desc as ProjectElementDesc,
    parent_project_id as ParentProjectId,
    entprojectelementtype as Entprojectelementtype,
    planned_start_date as PlannedStartDate,
    planned_end_date as PlannedEndDate,
    wbs_is_statistical as WbsIsStatistical,
    wbs_is_billing_element as WbsIsBillingElement,
    is_main_milestone as IsMainMilestone,
    responseuuid as Responseuuid,
    status as Status
}
