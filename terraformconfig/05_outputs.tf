
output "MyIp" {
  value       = data.http.myip.response_body
  description = "value of my IP address"
}

