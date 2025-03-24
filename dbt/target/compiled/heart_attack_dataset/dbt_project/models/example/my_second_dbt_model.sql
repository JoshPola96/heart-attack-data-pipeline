-- Use the `ref` function to select from other models

select *
from `heart-attack-dataset`.`heart_attack_dataset`.`my_first_dbt_model`
where id = 1