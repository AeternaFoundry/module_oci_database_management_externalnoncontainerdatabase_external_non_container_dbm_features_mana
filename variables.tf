variable "database_management_externalnoncontainerdatabase_external_non_container_dbm_features_managements" {
  description = <<EOT
Map of database_management_externalnoncontainerdatabase_external_non_container_dbm_features_managements, attributes below
Required:
    - enable_external_non_container_dbm_feature
    - external_non_container_database_id
Optional:
    - feature_details (block):
        - can_enable_all_current_pdbs (optional)
        - connector_details (optional, block):
            - connector_type (optional)
            - database_connector_id (optional)
            - management_agent_id (optional)
            - private_end_point_id (optional)
        - feature (required)
        - is_auto_enable_pluggable_database (optional)
        - license_model (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    enable_external_non_container_dbm_feature = bool
    external_non_container_database_id        = string
    feature_details = optional(object({
      can_enable_all_current_pdbs = optional(bool)
      connector_details = optional(object({
        connector_type        = optional(string)
        database_connector_id = optional(string)
        management_agent_id   = optional(string)
        private_end_point_id  = optional(string)
      }))
      feature                           = string
      is_auto_enable_pluggable_database = optional(bool)
      license_model                     = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.database_management_externalnoncontainerdatabase_external_non_container_dbm_features_managements : (
        v.feature_details == null || (contains([for v in ["DB_LIFECYCLE_MANAGEMENT", "DIAGNOSTICS_AND_MANAGEMENT", "SQLWATCH"] : lower(v)], lower(v.feature_details.feature)))
      )
    ])
    error_message = "must be one of: \"DB_LIFECYCLE_MANAGEMENT\", \"DIAGNOSTICS_AND_MANAGEMENT\", \"SQLWATCH\""
  }
  validation {
    condition = alltrue([
      for k, v in var.database_management_externalnoncontainerdatabase_external_non_container_dbm_features_managements : (
        v.feature_details == null || (v.feature_details.connector_details == null || (v.feature_details.connector_details.connector_type == null || (contains([for v in ["DIRECT", "EXTERNAL", "MACS", "PE"] : lower(v)], lower(v.feature_details.connector_details.connector_type)))))
      )
    ])
    error_message = "must be one of: \"DIRECT\", \"EXTERNAL\", \"MACS\", \"PE\""
  }
}

