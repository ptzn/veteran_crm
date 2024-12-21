db_migrate:
	bundle exec rake db:migrate

annotate:
	bundle exec annotaterb models

migrate: db_migrate annotate

dev:
	foreman start
