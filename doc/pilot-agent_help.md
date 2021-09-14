# Some usefull information about `pilot-agent` bin.

Version of Istio: 1.10.x

- [1. `pilot-agent` help documentation](#1-pilot-agent-help-documentation)
- [2. `pilot-agent` Dockerfile entrypoint command](#2-pilot-agent-dockerfile-entrypoint-command)

## 1. `pilot-agent` help documentation

```bash
istio-proxy@istio-egressgateway-abcdef1234-56789:/$ /usr/local/bin/pilot-agent help
Istio Pilot agent runs in the sidecar or gateway container and bootstraps Envoy.

Usage:
  pilot-agent [command]

Available Commands:
  help                 Help about any command
  istio-clean-iptables Clean up iptables rules for Istio Sidecar
  istio-iptables       Set up iptables rules for Istio Sidecar
  proxy                Envoy proxy agent
  request              Makes an HTTP request to the Envoy admin API
  version              Prints out build version information
  wait                 Waits until the Envoy proxy is ready

Flags:
  -h, --help                          help for pilot-agent
      --log_as_json                   Whether to format output as JSON or in plain console-friendly format
      --log_caller string             Comma-separated list of scopes for which to include caller information, scopes can be any of [ads, adsc, all, authn, authorization, ca, cache, citadelclient, default, dns, gcecred, googleca, healthcheck, klog, mockcred, model, sds, spiffe, stsclient, stsserver, telemetry, token, trustBundle, validation, wasm, wle, xdsproxy]
      --log_output_level string       Comma-separated minimum per-scope logging level of messages to output, in the form of <scope>:<level>,<scope>:<level>,... where scope can be one of [ads, adsc, all, authn, authorization, ca, cache, citadelclient, default, dns, gcecred, googleca, healthcheck, klog, mockcred, model, sds, spiffe, stsclient, stsserver, telemetry, token, trustBundle, validation, wasm, wle, xdsproxy] and level can be one of [debug, info, warn, error, fatal, none] (default "default:info")
      --log_rotate string             The path for the optional rotating log file
      --log_rotate_max_age int        The maximum age in days of a log file beyond which the file is rotated (0 indicates no limit) (default 30)
      --log_rotate_max_backups int    The maximum number of log file backups to keep before older files are deleted (0 indicates no limit) (default 1000)
      --log_rotate_max_size int       The maximum size in megabytes of a log file beyond which the file is rotated (default 104857600)
      --log_stacktrace_level string   Comma-separated minimum per-scope logging level at which stack traces are captured, in the form of <scope>:<level>,<scope:level>,... where scope can be one of [ads, adsc, all, authn, authorization, ca, cache, citadelclient, default, dns, gcecred, googleca, healthcheck, klog, mockcred, model, sds, spiffe, stsclient, stsserver, telemetry, token, trustBundle, validation, wasm, wle, xdsproxy] and level can be one of [debug, info, warn, error, fatal, none] (default "default:none")
      --log_target stringArray        The set of paths where to output the log. This can be any path as well as the special values stdout and stderr (default [stdout])

Use "pilot-agent [command] --help" for more information about a command.
```

## 2. `pilot-agent` Dockerfile entrypoint command

In the official [Dockerfile.proxyv2](https://github.com/istio/istio/blob/master/pilot/docker/Dockerfile.proxyv2),
the `ENTRYPOINT` for `pilot-agent` looks like this:

```dockerfile
[...]
# The pilot-agent will bootstrap Envoy.
ENTRYPOINT ["/usr/local/bin/pilot-agent"]
```

We might want to add the `wait` command and try
`/usr/local/bin/pilot-agent wait` in our custom `entrypoint.sh` script.

```bash
istio-proxy@istio-egressgateway-abcdef1234-56789:/$ /usr/local/bin/pilot-agent wait
2021-09-14T09:40:26.168398Z     info    Waiting for Envoy proxy to be ready (timeout: 60 seconds)...
2021-09-14T09:40:26.171822Z     info    Envoy is ready!
```