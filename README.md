# lockrun-cookbook
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
    <td><tt>['lockrun']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
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
