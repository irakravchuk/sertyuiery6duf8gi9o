
Available Variables
There are a variety of available variable references you can use.

» User string variables
Use the var. prefix followed by the variable name. For example, ${var.foo} will interpolate the foo variable value.

» User map variables
The syntax is var.MAP["KEY"]. For example, ${var.amis["us-east-1"]} would get the value of the us-east-1 key within the amis map variable.

» User list variables
The syntax is "${var.LIST}". For example, "${var.subnets}" would get the value of the subnets list, as a list. You can also return list elements by index: ${var.subnets[idx]}.

» Attributes of your own resource
The syntax is self.ATTRIBUTE. For example ${self.private_ip} will interpolate that resource's private IP address.

Note: The self.ATTRIBUTE syntax is only allowed and valid within provisioners.

» Attributes of other resources
The syntax is TYPE.NAME.ATTRIBUTE. For example, ${aws_instance.web.id} will interpolate the ID attribute from the aws_instance resource named web. If the resource has a count attribute set, you can access individual attributes with a zero-based index, such as ${aws_instance.web.0.id}. You can also use the splat syntax to get a list of all the attributes: ${aws_instance.web.*.id}.

» Attributes of a data source
The syntax is data.TYPE.NAME.ATTRIBUTE. For example. ${data.aws_ami.ubuntu.id} will interpolate the id attribute from the aws_ami data source named ubuntu. If the data source has a count attribute set, you can access individual attributes with a zero-based index, such as ${data.aws_subnet.example.0.cidr_block}. You can also use the splat syntax to get a list of all the attributes: ${data.aws_subnet.example.*.cidr_block}.

» Outputs from a module
The syntax is MODULE.NAME.OUTPUT. For example ${module.foo.bar} will interpolate the bar output from the foo module.

» Count information
The syntax is count.FIELD. For example, ${count.index} will interpolate the current index in a multi-count resource. For more information on count, see the resource configuration page.

» Path information
The syntax is path.TYPE. TYPE can be cwd, module, or root. cwd will interpolate the current working directory. module will interpolate the path to the current module. root will interpolate the path of the root module. In general, you probably want the path.module variable.

» Terraform meta information
The syntax is terraform.FIELD. This variable type contains metadata about the currently executing Terraform run. FIELD can currently only be env to reference the currently active state environment.

» Conditionals
Interpolations may contain conditionals to branch on the final value.

resource "aws_instance" "web" {
  subnet = "${var.env == "production" ? var.prod_subnet : var.dev_subnet}"
}
The conditional syntax is the well-known ternary operation:

CONDITION ? TRUEVAL : FALSEVAL
The condition can be any valid interpolation syntax, such as variable access, a function call, or even another conditional. The true and false value can also be any valid interpolation syntax. The returned types by the true and false side must be the same.

The supported operators are:

Equality: == and !=
Numerical comparison: >, <, >=, <=
Boolean logic: &&, ||, unary !
A common use case for conditionals is to enable/disable a resource by conditionally setting the count:

resource "aws_instance" "vpn" {
  count = "${var.something ? 1 : 0}"
}
In the example above, the "vpn" resource will only be included if "var.something" evaluates to true. Otherwise, the VPN resource will not be created at all.
