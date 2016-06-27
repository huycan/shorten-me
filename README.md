# Shorten me


## Specs

### Features
- [x] Input a Url and get it shortened
- [x] Redirect to the correct URL when public users enter the shortened URL link
- [x] Provide simple analytics with basic graphs / numbers (when going to shorten.me/[code]+)
  - [x] Total hits (a hit is simple a redirect)
  - [x] Daily hits last 7 days
  - [x] Total hits by browser
  - [x] Please build it such that additional analytics requirement (e.g. click by countrys etc.) will be easily supported

### UI - 2 pages
* A homepage where users get their links shortened
* An analytics page for each shortened link

### Notes
* Decent looking UI
* Design with performance / scalability in mind
* Explanation for technologies chosen
* REST-friendly


## Design Rationale

### Usage

Homepage: https://shoot-me.herokuapp.com/

Redirect: https://shoot-me.herokuapp.com/urls/:code, e.g. https://shoot-me.herokuapp.com/urls/b

Stats: https://shoot-me.herokuapp.com/:code, e.g. https://shoot-me.herokuapp.com/b

Steps:
* Enter full url, including protocol, to the box. The URL is not validated, so please be careful. My apology.
* Hit the button
* Copy the full url (the banana man is included specifically to make the copying difficult :D )
* Or click the url directly to immediately redirect

### Technologies

I choose Ruby on Rails and PostgreSql for back end, and jQuery and Bootstrap 4 for front end.

My strength lies not in proficiency or expertise in any language or framework, but rather the ability to learn and tinker. These technologies have stable and easy to use APIs, and rich documentation, and thus allows me to review web dev, learn and hack within 1 day.

### Performance

I use database indexes, cache, and background job to enhance performance. Cache and background job use default Rails implementation, they are meant to be placeholders in current design for later usage of real tools (e.g. Redis, Sidekiq, etc.)

### Class responsibility

* Controller: manage workflow and marshall data for view
* Model: query database
* View: I prefer client-side Javascript for interactive pages, which, as a side effect, pushes towards a reusable JSON api design for controller actions. I prefer ERB templating for mostly read-only pages.
  * Homepage: mainly jQuery
  * Stats: server-side rendering
* Service: encapsulate core logic meant for reuse and unit tests
* Job: move data across boundary between contexts, currently, between main service and reporting. This design isolates the coupling between main features to the data moving across boundary.

I do not write tests yet, but I try to actively refactor my code to prepare for later testing

### Extensibility for analytics requirement

Data pipeline:
* Source: HTTP request, and resources served to client
* Data model: select and filter relevant data from the source
* Storage: store data for later retrieval
* Sink: reporting services, query directly from database

The data source for analytics is mainly from HTTP request.
Thus, HttpRequestSerializerService is designed specifically to serialize ActionDispatch::Request to a hash for data collection. I can add more data to this hash.

The data is modelled as events, e.g. UrlVisit. So, I can add extra columns to collect new data. Event data are much richer than snapshot state data. Future services simply subscribe to the job queue for data, which allows data source to remain unaware and unaffected by future requirements.

I use PostgreSql because it has SQL, which was designed for querying and reporting.

### Where to go from here?

* Learn to use, then use Redis, Sidekiq, Chartkick
* Add graphs to stat pages
* Validate full url
* Write tests
* Move Javascript script out of homepage view into its own file
* Implement a copy-to-clipboard for shortened url in homepage


## Reference

* [Bootstrap template](http://v4-alpha.getbootstrap.com/examples/)
* [Base conversion algorithm](http://stackoverflow.com/questions/742013/how-to-code-a-url-shortener)