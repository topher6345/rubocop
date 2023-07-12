ENV.fetch('SERVICE_URL', 'staging')

ENV.fetch('SERVICE_URL')
ENV.fetch('DB_URL') { 'staging' }

ENV['DB_URL'] || 'staging'

foobar = ENV['DB_URL'] || 'staging'
# 