tests:
	bin/rails test

setup:
	cp -n .env.example .env || true

fixtures-load:
	bin/rails db:fixtures:load

clean:
	bin/rails db:drop

db-reset:
	bin/rails db:drop
	bin/rails db:create
	bin/rails db:migrate
	bin/rails db:fixtures:load

lint: lint-code lint-style

lint-code:
	bundle exec rubocop
	bundle exec slim-lint app/views/
	# TODO: add eslint

lint-style:
	npx stylelint "**/*.scss" "!**/vendor/**"

linter-code-fix:
	bundle exec rubocop -A

deploy:
	git push heroku main

heroku-console:
	heroku run rails console

heroku-logs:
	heroku logs --tail