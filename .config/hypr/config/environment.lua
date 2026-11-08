-- Match Noctalia's systemd-service application launching.
-- Also covers the launch-or-focus helper, which invokes `uwsm app`.
hl.env("UWSM_APP_UNIT_TYPE", "service")
