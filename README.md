# lockrun-cookbook
![Release](http://img.shields.io/github/release/johnbellone/lockrun-cookbook.svg)
[![Build Status](http://img.shields.io/travis/johnbellone/lockrun-cookbook.svg)][3]
[![Code Coverage](http://img.shields.io/coveralls/johnbellone/lockrun-cookbook.svg)][4]

Installs [lockrun][1] executable for running cronjobs with overrun
protection.

## Supported Platforms
- CentOS 7.0, 6.4, 5.8
- Ubuntu 14.04, 12.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['lockrun']['install_prefix']</tt></td>
    <td>String</td>
    <td>Location to install executable.</td>
    <td><tt>/usr/local/bin</tt></td>
  </tr>
  <tr>
    <td><tt>['lockrun']['lock_path']</tt></td>
    <td>String</td>
    <td>Location to store lockrun files.</td>
    <td><tt>/var/run</tt></td>
  </tr>
</table>

## Usage

### lockrun::default

Include `lockrun` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[lockrun::default]"
  ]
}
```
## License and Authors

Author:: [John Bellone][2] (<jbellone@bloomberg.net>)

[1]: http://www.unixwiz.net/tools/lockrun.html
[2]: https://github.com/johnbellone
[3]: http://travis-ci.org/johnbellone/lockrun-cookbook
[4]: https://coveralls.io/r/johnbellone/lockrun-cookbook
