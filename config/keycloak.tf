resource "keycloak_realm" "demo" {
  realm   = "demo"
  enabled = true
}

resource "keycloak_user" "alice" {
  realm_id = keycloak_realm.demo.id

  username = "alice"
  enabled  = true

  first_name     = "Alice"
  last_name      = "Example"
  email          = "alice@example.dev"
  email_verified = true

  initial_password {
    value = "alice"
  }
}

resource "keycloak_user" "bob" {
  realm_id = keycloak_realm.demo.id

  username = "bob"
  enabled  = true

  first_name     = "Bob"
  last_name      = "Example"
  email          = "bob@example.dev"
  email_verified = true

  initial_password {
    value = "bob"
  }
}

resource "keycloak_openid_client" "openbao" {
  realm_id = keycloak_realm.demo.id

  client_id = "openbao"
  enabled   = true

  access_type           = "CONFIDENTIAL"
  standard_flow_enabled = true

  root_url = "http://localhost:8200"
  base_url = "http://localhost:8200"
  valid_redirect_uris = [
    "http://localhost:8200/ui/vault/auth/oidc/oidc/callback",
    "http://127.0.0.1:8200/ui/vault/auth/oidc/oidc/callback",
    "http://localhost:8250/oidc/callback",
    "http://127.0.0.1:8250/oidc/callback"
  ]
  web_origins = [
    "http://localhost:8200",
    "http://127.0.0.1:8200"
  ]
  admin_url = "http://localhost:8200/ui/vault/auth/oidc/oidc/callback"
}
