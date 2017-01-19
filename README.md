Rails developer assignment
Rails assignment The story
Vandebron wants to scale its jobs page, at the moment a hand maintained collection of HTML files.
To do this, we would like to build a jobs CMS that has a back end API and a front end application. The front end app is not in the scope of this assignment, but you should assume it will be a Single Page Application (SPA), expecting a REST API with JSON format.
Your assignment

Working with Rails 5.x, create a simple jobs CMS. The CMS models should map the following requirements:
A job has a title, description, and can be permanent or freelance.
Each job has one category. A category can have many jobs. Categories have a title. Each job can have keywords. A keyword be associated with many jobs.
The API should expose endpoints that allow jobs to be read (all or one), created, updated and deactivated or activated (but not deleted). It should accept a single request to create or update a job including setting its category and keyword(s).
The read endpoints should return jobs including their category and keywords.
The API should authorize requests using an API token (preferably configured using an environment variable).
Finally, the API should have an endpoint that accepts applications to apply for a job. This endpoint should accept something like the following:
{
  "name": "James Croxford",
  "email": "jc@gmail.com",
  "cover": "I would really like to apply for your job!",
  "CV": "<full text of CV>"
}
The endpoint should reject applications with an error message if the job is no longer active.
If the job is active, it should send the application via a mail API (for example Mandrill) to jobs@vandebron.nl with the data as-is.
Note: Fully implementing the mail API library is outside the scope of the assignment! Please simply use an empty class, and mock this class in your tests to show requests are correctly sent (or not sent, if the job is not active).
Deliverable
Complete source code, including migrations
README describing your solution, and how to configure and run it
Automated tests, using RSpec
What we'll be keen to see
Clear and readable code
Appropriate test coverage
Following Rails best practices
# Feature Checklist

* Models

  1. Job
    * title
    1. description
    1. permanent?
    1. belongs to one Category
    1. has many keywords
    1. activated/deactivated

  1. Category
    * title(string)
    1. has many Jobs

  1. Keyword
    * word(string)
    * has many Jobs
* Associations
    * Many jobs belong to one category
    * A job has and belongs to many keywords (join table)

* Endpoints
  1. Job
    * read(all or one)
    * create
    * update
    * activate/deactivate
    * can NOT delete job entries
    * API Token along with request
  1. Application for job
    * Accept application with a JSON format that contains name, email, cover letter, and CV.
    * If job is not active the application will be rejected (with error message)
