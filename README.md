# Portfolio-mmi project - Ruby on rails

## Order
We have to build a twitter copy-cat in Ruby on Rails.

## Features

- USER
	- CRUD
	- Register
	- Login
	- Avatar upload
	- Update profils
	- Create portfolio
		- Add picture
		- Add url
	- Update portfolio
	- Vote


- Portfolios
	- Filtred by profils

- Admin
	- Unpublish portfolio
	- Add cities
	- Add Job type

## Dependencies
- [Devise](https://github.com/plataformatec/devise) User management
- [carrierwave](https://github.com/carrierwaveuploader/carrierwave) Upload management for pictures
- [rmagick](https://github.com/rmagick) Picture proccesing
- [faker](https://github.com/stympy/faker) Create random data (seed)
- [kaminari](https://github.com/kaminari/kaminari) paginate

## Launch project
Running on [http://localhost:3000](http://localhost:3000)

	bundle install
	rake db:create
	rake db:migrate

	rails s

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

5.0.1

* ...
