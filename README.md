# rinku-crystal

Bindings for [Rinku](https://github.com/vmg/rinku), an autolinker

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
=> "<a href=\"http://www.google.com\">www.google.com</a> and some more text"

Rinku.auto_link("Email address goes here somebody@the-internet.xyz")
=> "Email address goes here <a href=\"mailto:somebody@the-internet.xyz\">somebody@the-internet.xyz</a>"

# Mode can be one of :all, :email or :urls
Rinku.auto_link("auto link url www.bing.com:8080/42 and do not link email somebody@the-internet.xyz", :urls)
=> "auto link url <a href=\"http://www.bing.com:8080/42\">www.bing.com:8080/42</a> and do not link email somebody@the-internet.xyz"
```

## Benchmark
Run `crystal run --release bench.cr` to check performance on your platform compared with [Autolink](https://github.com/crystal-community/autolink.cr). On the author's machine:

```
Autolink   3.20k (312.85µs) (± 2.09%)  43.2kB/op  51.63× slower
   Rinku 165.05k (  6.06µs) (± 2.58%)  2.08kB/op        fastest
```

The larger the string, the faster Rinku is compared to Autolink.


## Contributing

1. Fork it (<https://github.com/jamescook/rinku-crystal/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [James Cook](https://github.com/jamescook) - creator and maintainer
