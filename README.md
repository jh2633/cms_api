
### Work in progress!
* To-dos
 - Skinny-fying the Jobs controller
    - Fix issues surrounding POST/Update
 - Create empty class to mock the email action for valid application submission
 - Incorporate token
 - (all) Passing tests
 - Refactor

## Instructions
1. Fork and pull this repo
1. Install Rails & Ruby if not present on machine
1. Bundle the gems from the Gemfile using Bundler
1. Setup Postgres DBs according to the names in the config/database.yml file or change the names as you prefer
1. Run migration - bin/rails db:migrate
1. Run RSpec to view the passing/failing tests
1. Jobs can now be posted. If token is to be implemented using a .env file in the root directory, you can create it now to implement acceptable tokens.
  * SECURITY: Add .env to GITIGNORE to prevent any accidental push to a publicly viewable repository
1. Wait for updates to this repo!


# Features Checklist

* Models

  1. Job
    * title ✅
    1. description ✅
    1. permanent? ✅
    1. belongs to one Category ✅
    1. has many keywords ✅
    1. activated/deactivated ✅

  1. Category
    * title(string) ✅
    1. has many Jobs ✅

  1. Keyword
    * word(string) ✅
    * has many Jobs ✅
* Associations
    * Many jobs belong to one category✅
    * A job has and belongs to many keywords (join table) ❌

* Endpoints
  1. Job
    * read(all or one) ✅
    * create ✅
    * update ❌
    * activate/deactivate ✅
    * can NOT delete job entries ✅
    * API Token along with request ✅
  1. Application for job
    * Accept application with a JSON format that contains name, email, cover letter, and CV. ✅
    * If job is not active the application will be rejected (with error message) ❌
    * Mock class for emailing application if accepted ❌
