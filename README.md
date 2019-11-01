## create rails application

Given we have two models, Article and Story. Article has name, text and type (like blog post, facebook post or tweet).
Story has name and contains one or more articles.

There should be a single API enpoint that returns list of articles. Basing on query params list could be:

 - searched by article name or text
 - sorted on any field
 - grouped by any of field
 - grouped by story with totals:
   - article count
   - article type count
   - last created article according to current sort
