@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'State Value Help'
@Search.searchable: true
//@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_CEO_StateVH
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZCEO_STATE' )
{
      @UI.hidden: true
  key domain_name    as DomainName,
      @UI.hidden: true
  key value_position as ValuePosition,
      @UI.hidden: true
  key language       as Language,
      @EndUserText: { label: 'State', quickInfo: 'State' }
  key value_low      as State,
      @EndUserText: { label: 'Description', quickInfo: 'Description' }
      @Search.defaultSearchElement: true
      text           as StateDescription

}
where
  language = $session.system_language
