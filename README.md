# Testing `#invert_where` vs. explicit scope inversion

[`#invert_where`][iw] inverts _all_ preceding `#where` clauses in an
ActiveRecord query chain, including those contained within scopes. Instead,
retrieving and inverting the [`Arel::SelectManager#constraints`][constr] of
just the desired scope allows for order-independent scope chaining without
side effects.

Given the scopes defined in the`Foobar` model:

```ruby
Foobar.active.published
# SELECT "foobars".* FROM "foobars" WHERE "foobars"."expires_at" >= '2021-12-10 04:21:48.044576' AND "foobars"."published" = 1

Foobar.published.active
# SELECT "foobars".* FROM "foobars" WHERE "foobars"."published" = 1 AND "foobars"."expires_at" >= '2021-12-10 04:21:48.044576'

Foobar.expired_inverse_of.published
# SELECT "foobars".* FROM "foobars" WHERE NOT ("foobars"."expires_at" >= '2021-12-10 04:21:48.044576') AND "foobars"."published" = 1

Foobar.published.expired_inverse_of
# SELECT "foobars".* FROM "foobars" WHERE "foobars"."published" = 1 AND NOT ("foobars"."expires_at" >= '2021-12-10 04:21:48.044576')

Foobar.expired_invert_where.published
# SELECT "foobars".* FROM "foobars" WHERE "foobars"."expires_at" < '2021-12-10 04:21:48.044576' AND "foobars"."published" = 1

Foobar.published.expired_invert_where
# SELECT "foobars".* FROM "foobars" WHERE NOT ("foobars"."published" = 1 AND "foobars"."expires_at" >= '2021-12-10 04:21:48.044576')
```

[iw]: https://edgeapi.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-invert_where
