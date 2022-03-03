# ==========================================================================
#  Services: Airflow / outputs.tf (Output Terraform)
# --------------------------------------------------------------------------
#  Description
# --------------------------------------------------------------------------
#    - Return value ec2 module
# ==========================================================================

output "arn" {
  value = {
    instance_arn       = aws_instance.airflow.arn,
    keypair_arn        = aws_key_pair.airflow_ssh_key.arn,
    security_group_arn = aws_security_group.airflow.arn,
  }
}
output "instance" {
  value = {
    bucket_name    = local.bucket_name
    private_ipv4   = "${aws_eip.airflow.private_ip}"
    public_dns     = "${aws_route53_record.airflow.name}"
    public_ipv4    = "${aws_eip.airflow.public_ip}"
    ssh_access_dns = "ssh ec2-user@${aws_route53_record.airflow.name}"
    ssh_access_ip  = "ssh ec2-user@${aws_eip.airflow.public_ip}"
    subnet_id      = local.subnet_id
    vpc_id         = data.aws_vpc.selected.id
  }
}

output "route53" {
  value = {
    dns_name = aws_route53_record.airflow.name
    fqdn     = aws_route53_record.airflow.fqdn
    records  = aws_route53_record.airflow.records
    type     = aws_route53_record.airflow.type
    zone_id  = aws_route53_record.airflow.zone_id
  }
}
