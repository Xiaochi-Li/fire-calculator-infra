output "ecs_sg_ids" {
  value = module.ecs_service[*].ecs_sg_ids
}
