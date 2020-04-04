# 20.02.06現在最新安定版のイメージを取得
FROM ruby:2.6.5
# rails cで日本語が打てるように設定
ENV LANG C.UTF-8
# 日本時間
ENV TZ='Asia/Tokyo'
# 必要なパッケージのインストール（基本的に必要になってくるものだと思うので削らないこと）
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       nodejs \
                       # For gem 'whenever'   
                       cron \
                       vim    

# Install Yarn 
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# 作業ディレクトリの作成、設定
RUN mkdir /quiz 
##作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /quiz 
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileを追加する
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileのbundle install
RUN yarn install --check-files
RUN gem install bundler
RUN bundle install
ADD . $APP_ROOT

# 秘密鍵を追加
RUN mkdir ~/.ssh
    # ADDで "~(チルダ)" は使えないため、ディレクトリ"quiz"から相対パスで指定
ADD .ssh/quiz_wadokaichin_key_rsa ../root/.ssh/quiz_wadokaichin_key_rsa
ADD .ssh/git_id_rsa ../root/.ssh/git_id_rsa
RUN echo "\n\
Host github                         \n\
  HostName github.com               \n\
  IdentityFile ~/.ssh/git_id_rsa    \n\
  Port 22                           \n\
  User git                          \n\
                                    \n\
Host quiz_wadokaichin_key_rsa       \n\
  Hostname 18.176.129.236           \n\
  Port 22                           \n\
  User ys8906                       \n\
  IdentityFile ~/.ssh/quiz_wadokaichin_key_rsa" >> ~/.ssh/config

# Update cron tasks by whenever
RUN bundle exec whenever --update-crontab
