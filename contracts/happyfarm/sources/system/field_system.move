module happyfarm::field_system {

    use happyfarm::world::World;
    use happyfarm::player_info_schema;
    use happyfarm::field_info_schema;
    use happyfarm::global_schema;
    use happyfarm::entity_key;
    use sui::tx_context::{TxContext,Self};
    use happyfarm::plant_schema;
    use happyfarm::plant_attrs_schema;
    
    const E_Score_Not_Enough:u64 = 1001;
    
    public entry fun buy_a_field(world: &mut World,ctx: &mut TxContext){
        let field_price = global_schema::get_field_price(world);
        let field_number = global_schema::get_last_field_no(world);
        let addr = tx_context::sender(ctx);
        let (score,register) = player_info_schema::get(world,addr);
        assert!(register && score >= field_price,E_Score_Not_Enough);
        let new_score = score - field_price;
        player_info_schema::set_score(world,addr,new_score);
        
        let field_key = entity_key::from_u256((field_number as u256));
        field_info_schema::set(world,field_key,addr,field_number,field_number * 100);

        global_schema::set_last_field_no(world,field_number+1);
    }

    fun get_skill_need_score(world: &mut World,skill_type:u8):u64 {
        if (skill_type == 0){
            global_schema::get_rain_score_need(world)
        }else if (skill_type == 1){
            global_schema::get_snow_score_need(world)
        }else if (skill_type == 2){
            global_schema::get_wind_score_need(world)
        } else {
            global_schema::get_sun_score_need(world)
        }
    }

    fun get_affect_score(world: &mut World,skill_type:u8,plant_type:address):u64 {
        if (skill_type == 0){
            plant_attrs_schema::get_rain_effct(world,plant_type)
        }else if (skill_type == 1){
            plant_attrs_schema::get_snow_effct(world,plant_type)
        }else if (skill_type == 2){
            plant_attrs_schema::get_wind_effct(world,plant_type)
        } else {
            plant_attrs_schema::get_sun_effect(world,plant_type)
        }
    }


    public entry fun apply_skill(world: &mut World,filed_addr:address,skill_type:u8,ctx: &mut TxContext){
        let addr = tx_context::sender(ctx);
        let skill_need_score = get_skill_need_score(world,skill_type);
        let (score,register) = player_info_schema::get(world,addr);
        assert!(register && score >= skill_need_score,E_Score_Not_Enough);
        let new_score = score - skill_need_score;
        player_info_schema::set_score(world,addr,new_score);

        let field_number = field_info_schema::get_filed_no(world,filed_addr);
        let last_plant_number = field_info_schema::get_last_plant_no(world,filed_addr);
        let loop_key = 100 * field_number;
        while( loop_key < last_plant_number ) {
            let plant_key = entity_key::from_u256((loop_key as u256));
            if(!plant_schema::get_harvested(world,plant_key)){
                let plant_type_addr = plant_schema::get_plant_type(world,plant_key);
                let affect = get_affect_score(world,skill_type,plant_type_addr);
                let plant_score = plant_schema::get_score(world,plant_key);
                let new_score = plant_score + affect;
                let max_score = plant_attrs_schema::get_harvest_socre(world,plant_type_addr);
                if(new_score > max_score){
                    new_score = max_score;
                };
                plant_schema::set_score(world,plant_key,new_score);
            };
            loop_key = loop_key + 1;    
        }
    }

}
