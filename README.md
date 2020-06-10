# rinku-crystal

WIP - Bindings for Rinku

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     rinku-crystal:
       github: jamescook/rinku-crystal
   ```

2. Run `shards install`

3. Compile the Rinku library and copy it to where your platform stores libraries (e.g. /usr/local/lib). The `Makefile` in this repo may work for your platform.


## Usage

```crystal
require "rinku"

Rinku.auto_link("www.google.com and some more text")
```


## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/jamescook/rinku-crystal/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [James Cook](https://github.com/jamescook) - creator and maintainer
