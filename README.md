# What this app does
This is a backend API that supports managing of apps; similar to appstore. It uses Doorkeeper tokens to authenticate users. Listing of apps is public, but creating, updating, and deleting apps is only for authenticated users.

# How to run the app

- Clone the repository
- Use any version manager to install the project version (e.g. rbenv)
- Run `bundle install`
- Run `rails db:migrate`
- Run `rails server`
- Interact with the API using Postman or any API client

# API Endpoints
**NOTE:** All endpoints listed below require authentication with `Bearer token` except for the ones marked with **

**Gotchas:** 
- Don't forget to add `Bearer __your_token__` in the `Authorization` header
- Don't forget to add `Content-Type: application/json` in the `Headers` section

### Users
- POST localhost:3000/v1/users/create **
- POST localhost:3000/v1/users/login **
- GET localhost:3000/v1/users/me

### Client Apps
- GET localhost:3000/v1/client_apps **
- GET localhost:3000/v1/client_apps?filter=_filter_text_ **
- GET localhost:3000/v1/client_apps/:id **
- POST localhost:3000/v1/client_apps
- PUT localhost:3000/v1/client_apps/:id
- DELETE localhost:3000/v1/client_apps/:id

### Example Requests:
 - Create user:
 ```bash
#Request Sent: 
curl --location --request POST 'localhost:3000/v1/users/create' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "me@apple.com",
    "password": "123456",
    "password_confirmation": "123456"
}'

#Response Received:
{
    "uuid": "86589dca-6e50-4ea5-b657-2ff7c08dfa26",
    "email": "me@apple.com",
    "status": "active"
}
 ```

 - Login user:
 ```bash
#Request Sent: 
curl --location --request POST 'localhost:3000/v1/users/login' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "me@apple.com",
    "password": "123456"
}'

#Response Received:
{
    "access_token": "fbt7_jKPp3ajURfHhyRrfLkwNoDSI9aHdBWhhYSJ1oU",
    "refresh_token": "6OViluhqLRqndNiwfhIOW7RIyGm07sHdP5pWdYlQArs",
    "created_at": "2026-01-15T01:17:19.791Z",
    "expires_in": 3600,
    "token_type": "bearer"
}
```

- Get user profile:
```bash
#Request Sent: 
curl --location --request GET 'localhost:3000/v1/users/me' \
--header 'Authorization: Bearer fbt7_jKPp3ajURfHhyRrfLkwNoDSI9aHdBWhhYSJ1oU'

#Response Received:
{
    "uuid": "86589dca-6e50-4ea5-b657-2ff7c08dfa26",
    "email": "me@apple.com",
    "status": "active"
}
```

- Create client app:
```bash
#Request Sent: 
curl --location --request POST 'localhost:3000/v1/client_apps' \
--header 'Authorization: Bearer 6WD8eQlWQD-nFzSQEy4MdV1gDlodixfl0tB2ES7fIGw' \
--form 'name="maps"' \
--form 'tagline="Apple Maps"' \
--form 'image_filename=@"/Users/jayandra/Downloads/IMG_8065.heic"'

#Response Received:
{
    "id": 23,
    "name": "maps",
    "tagline": "Apple Maps",
    "image_url": "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MTksInB1ciI6ImJsb2JfaWQifX0=--1fa9487f9ad68d2791a5e7184c8bf1cb80c88b7c/IMG_8065.heic"
}
```

- Filter client apps:
```bash
#Request Sent: 
curl --location --request GET 'localhost:3000/v1/client_apps?filter=apple'

#Response Received:
[
    {
        "id": 19,
        "name": "maps",
        "tagline": "Apple Maps",
        "image_url": "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MTUsInB1ciI6ImJsb2JfaWQifX0=--8d849ff8ceb248ec333b85c7322715c6b4b26feb/IMG_8065.heic"
    }
]
```
