# frozen_string_literal: true

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

## Docker上でのcron管理について
# ■docker上でcronを起動/停止する方法
# ・docker exec -it [container_name(quiz_web_1)] /bin/bash
# ・service cron start/stop
# ・service cron status (もしくはps aux）: cronが動いていることを確認

# ■タスクスケジュールを更新する方法
# ・config/schedule.rbを編集
# ・docker exec -it [container_name(quiz_web_1)] /bin/bash
# ・whenever --update-crontab
# （whenever --clear-crontab: スケジュールを削除）

ENV.each { |k, v| env(k, v) }
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
set :output, 'log/whenever.log'

if rails_env.to_sym == :production
  every :day, at: "12:00am" do
    begin
      runner 'Batch.new.generate_quiz_wadokaichin'
    rescue => e
      Rails.logger.error("aborted batch")
    end
  end
end

