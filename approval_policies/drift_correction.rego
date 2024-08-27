package env0

# METADATA
# title: allow if no monthly cost
# description: approve automatically if the plan has no changes

allow[msg] {
	not any_resources_with_change
	msg := "approve automatically, no resources changed"
}

allow[msg] {
	input.deploymentRequest.triggerName == "scheduled"
    	input.deployerUser.userId == "env0-system"
	msg := "approve automatically, drift correction"
}

any_resources_with_change {
	input.plan.resource_changes[_].change.actions[_] != "no-op"
}
