# Portfolio-mmi project - Ruby on rails

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

## Dependencies (gem)
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

## Ruby version

5.0.1

