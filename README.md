# Api Sample

This is an example of an JSON Restful API used to index any site contents (currently 'h1', 'h2', 'h3' and 'a' tags). See API routes for more info on how to use it.

## System Info

| System | Details  |
|---|---|
| Ruby  | 2.3.1  |
| Rails  |  4.2.7.1 |
| Testing | Rspec  |
| API System | Grape |


## Getting Started

1. Clone the repository

`git clone https://github.com/fabianoarruda/api-sample`    

2. Install gems

`bundle install`

## Database

A sqlite3 database is already included in the repository. If you want to clean its contents:

`rake db:reset`

## Running Tests

`rspec`

## API Routes

To see the Api routes run:

`rake api:routes`

Output:

    GET        /api/v1/pages(.json)  ----  Return a list of Pages.
    GET        /api/v1/pages/:id(.json)  ----  Return a specific page by id.
    GET        /api/v1/pages/:id/tags(.json)  ----  Return all tags indexed on a given page. Can by optionally filtered by tag name
    POST       /api/v1/pages(.json)  ----  Receive an url and index its contents.
    
    