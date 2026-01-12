@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Weighbridge Projection Head'

@UI.headerInfo: {
  typeName: 'Project Milestone',
  typeNamePlural: 'Project Milestones',
  title: {
    type: #STANDARD,
    label: 'Project Element',
    value: 'ProjectElement'
  },
  description: {
    type: #STANDARD,
    label: 'Description',
    value: 'ProjectElementDesc'
  },
  typeImageUrl: 'sap-icon://group'
}

define root view entity ZC_PROJECT_UPL
  provider contract transactional_query
  as projection on Zi_Project_Upl
{



@UI.facet: [
  {
    id:              'GeneralInfo',
    type:            #IDENTIFICATION_REFERENCE,
    label:           'General Information',
    position:        10
  }
]



  @EndUserText.label: 'Project Element'
  @UI.lineItem:        [{ position: 10 }]
  @UI.identification: [{ position: 10 }]
  @UI.selectionField: [{ position: 10 }]
  key ProjectElement,

  @EndUserText.label: 'WBS Element ID'
  @UI.lineItem:        [{ position: 20 }]
  @UI.identification: [{ position: 20 ,type: #FOR_ACTION, dataAction: 'post1',  label: 'Post' }]
    @UI.selectionField: [{ position: 20 }]
  WbselementId,

  @EndUserText.label: 'Project ID'
  @UI.lineItem:        [{ position: 30,  type: #FOR_ACTION, dataAction: 'post1',  label: 'Post' }]
  @UI.identification: [{ position: 30 }]
  ProjectId,

  @EndUserText.label: 'Project Element Description'
  @UI.lineItem:        [{ position: 40 }]
  @UI.identification: [{ position: 40 }]
  ProjectElementDesc,

  @EndUserText.label: 'Parent Project ID'
  @UI.lineItem:        [{ position: 50 }]
  @UI.identification: [{ position: 50 }]
  ParentProjectId,

  @EndUserText.label: 'Project Element Type'
  @UI.lineItem:        [{ position: 60 }]
  @UI.identification: [{ position: 60 }]
  Entprojectelementtype,

  @EndUserText.label: 'Planned Start Date'
  @UI.lineItem:        [{ position: 70 }]
  @UI.identification: [{ position: 70 }]
  PlannedStartDate,

  @EndUserText.label: 'Planned End Date'
  @UI.lineItem:        [{ position: 80 }]
  @UI.identification: [{ position: 80 }]
  PlannedEndDate,

  @EndUserText.label: 'WBS Is Statistical'
  @UI.lineItem:        [{ position: 90 }]
  @UI.identification: [{ position: 90 }]
  WbsIsStatistical,

  @EndUserText.label: 'WBS Is Billing Element'
  @UI.lineItem:        [{ position: 100 }]
  @UI.identification: [{ position: 100 }]
  WbsIsBillingElement,

  @EndUserText.label: 'Is Main Milestone'
  @UI.lineItem:        [{ position: 110 }]
  @UI.identification: [{ position: 110 }]
  IsMainMilestone,

  Responseuuid,
  
  @EndUserText.label: 'Posting Status'
  @UI.lineItem:        [{ position: 120 }]
  @UI.identification: [{ position: 120 }]
  @UI.selectionField: [{ position: 30 }]
  @Consumption.valueHelpDefinition: [{ entity.name: 'ZVH_STATUS' , entity.element: 'Status' }]
  Status
}
