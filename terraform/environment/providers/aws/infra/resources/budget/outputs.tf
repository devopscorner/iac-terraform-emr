# ==========================================================================
#  Resources: Budget / outputs.tf (Outputs Terraform)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - Budget Configuration
# ==========================================================================

output "budget_info" {
  value = {
    budget_name        = aws_budgets_budget.monthly.name
    budget_type        = aws_budgets_budget.monthly.budget_type
    budget_limit       = aws_budgets_budget.monthly.limit_amount
    budget_limit_unit  = aws_budgets_budget.monthly.limit_unit
    budget_time_unit   = aws_budgets_budget.monthly.time_unit
    budget_time_period = aws_budgets_budget.monthly.time_period_start
  }
}

output "budget_notif" {
  value = {
    notif_operator       = aws_budgets_budget.monthly.notification
  }
}
