DataMapper.logger = logger
DataMapper::Property::String.length(255)

case Padrino.env
  when :development then DataMapper.setup(:default, 'sqlite3://' + Padrino.root('db', 'job_vacancy_development.db'))
  when :travis      then DataMapper.setup(:default, 'sqlite3::memory:')
  when :test         then DataMapper.setup(:default, 'sqlite3::memory:')
  when :staging 		then DataMapper.setup(:default, ENV['DATABASE_URL'])
  when :production  then DataMapper.setup(:default, ENV['DATABASE_URL'])
end
