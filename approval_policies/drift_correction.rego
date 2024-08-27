package env0

# METADATA
# title: allow if no monthly cost
# description: approve automatically if the plan has no changes

allow[format(rego.metadata.rule())] {
	not any_resources_with_change
}

allow[format(rego.metadata.rule())] {
	input.deploymentRequest.triggerName == "scheduled"
    	input.deployerUser.userId == "env0-system"
}

any_resources_with_change {
	input.plan.resource_changes[_].change.actions[_] != "no-op"
}
