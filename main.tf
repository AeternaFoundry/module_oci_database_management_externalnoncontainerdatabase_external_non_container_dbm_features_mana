resource "oci_database_management_externalnoncontainerdatabase_external_non_container_dbm_features_management" "database_management_externalnoncontainerdatabase_external_non_container_dbm_features_managements" {
  for_each = var.database_management_externalnoncontainerdatabase_external_non_container_dbm_features_managements

  enable_external_non_container_dbm_feature = each.value.enable_external_non_container_dbm_feature
  external_non_container_database_id        = each.value.external_non_container_database_id

  dynamic "feature_details" {
    for_each = each.value.feature_details != null ? [each.value.feature_details] : []
    content {
      can_enable_all_current_pdbs = feature_details.value.can_enable_all_current_pdbs
      dynamic "connector_details" {
        for_each = feature_details.value.connector_details != null ? [feature_details.value.connector_details] : []
        content {
          connector_type        = connector_details.value.connector_type
          database_connector_id = connector_details.value.database_connector_id
          management_agent_id   = connector_details.value.management_agent_id
          private_end_point_id  = connector_details.value.private_end_point_id
        }
      }
      feature                           = feature_details.value.feature
      is_auto_enable_pluggable_database = feature_details.value.is_auto_enable_pluggable_database
      license_model                     = feature_details.value.license_model
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

