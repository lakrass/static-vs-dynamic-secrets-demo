resource "vault_jwt_auth_backend" "oidc" {
  depends_on = [keycloak_openid_client.openbao]
  type       = "oidc"
  path       = "oidc"

  oidc_client_id     = keycloak_openid_client.openbao.client_id
  oidc_client_secret = keycloak_openid_client.openbao.client_secret
  oidc_discovery_url = "http://localhost:8080/realms/demo"
  bound_issuer       = "http://localhost:8080/realms/demo"

  default_role = "default"

  tune {
    listing_visibility = "unauth"
  }
}

resource "vault_jwt_auth_backend_role" "default" {
  backend = vault_jwt_auth_backend.oidc.path

  role_name      = "default"
  token_policies = ["default"]

  user_claim            = "sub"
  allowed_redirect_uris = keycloak_openid_client.openbao.valid_redirect_uris
}
