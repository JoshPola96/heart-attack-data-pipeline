
  
    

    create or replace table `heart-attack-dataset`.`heart_attack_dataset`.`optimized_table`
      
    
    cluster by gender, region, hypertension, diabetes

    OPTIONS()
    as (
      

SELECT * FROM `heart-attack-dataset`.`heart_attack_dataset`.`cleaned_data`
    );
  