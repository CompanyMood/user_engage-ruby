# v0.0.6

  * update dry-struct from 0.4 to 0.5

## Breaking changes

  * `UserEngage::User.new.attributes` returns a Hash with all attributes of the UserEngage::User instance.
     In previous versions, a call on `.attributes` would have returned an `Array` of UserEngage::Attribute.
     If you want to get the `Array` of attributes you can use `.attributes[:attributes]`
