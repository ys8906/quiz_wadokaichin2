require 'sshkit'
require 'sshkit/dsl'
include SSHKit::DSL

SSHKit.config.output_verbosity = Logger::DEBUG

remote_host = SSHKit::Host.new('18.176.129.236')
remote_host.user = "ys8906"
remote_host.ssh_options = {
    keys: %w(~/.ssh/quiz_wadokaichin.pem),
    forward_agent: false,
    auth_methods: %w(publickey)
}

on remote_host do
  execute :ls
end