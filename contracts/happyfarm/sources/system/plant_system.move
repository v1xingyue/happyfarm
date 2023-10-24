module happyfarm::plant_system {

    use happyfarm::world::World;
    use happyfarm::plant_attrs_schema;
    use happyfarm::plant_schema;
    use happyfarm::player_info_schema;
    use happyfarm::field_info_schema;
    use sui::tx_context::{TxContext,Self};
    use happyfarm::entity_key;
    
    const E_Score_Not_Enough:u64 = 1001;
    const E_Plant_Not_Mature:u64 = 1002;
    const E_Field_Full:u64 = 1003;

    const FIELD_MAX_SIZE:u64 = 10;
    
    public entry fun make_plant(world: &mut World, key: address,url: vector<u8>, init_score: u64, harvest_socre: u64, sun_effect: u64, wind_effct: u64, rain_effct: u64, snow_effct: u64,_ctx: &mut TxContext){
        // let admin_addr = global_schema::get_admin(world);
        // let addr = tx_context::sender(ctx);
        // assert!(addr == admin_addr,E_Is_Not_Admin);
        plant_attrs_schema::set(world,key,url,init_score,harvest_socre,sun_effect,wind_effct,rain_effct,snow_effct);
    }

    public entry fun grow_plant(world:&mut World,field_addr:address,plant_type:address,ctx: &mut TxContext){
        let range_from = field_info_schema::get_filed_no(world,field_addr) * 100;
        let plant_no = field_info_schema::get_last_plant_no(world,field_addr);
        assert!(plant_no < range_from+FIELD_MAX_SIZE,E_Field_Full);
        let plant_key = entity_key::from_u256((plant_no as u256));
        let (_,init_score,_,_,_,_,_) = plant_attrs_schema::get(world,plant_type);
        let addr = tx_context::sender(ctx);
        let player_score = player_info_schema::get_score(world,addr);
        assert!(player_score >= init_score,E_Score_Not_Enough);
        player_info_schema::set_score(world,addr,player_score-init_score);
        plant_schema::set(world,plant_key,init_score,addr,plant_type,false);
        field_info_schema::set_last_plant_no(world,field_addr,plant_no+1);
    }

    public entry fun harvest_plant(world:&mut World,field_addr:address,plant_addr:address){
        let (score,owner,plant_type,_) = plant_schema::get(world,plant_addr);
        let harvest_socre = plant_attrs_schema::get_harvest_socre(world,plant_type);
        assert!(score == harvest_socre,E_Plant_Not_Mature);
        let player_score = player_info_schema::get_score(world,owner);
        player_info_schema::set_score(world,owner,player_score+score-5);
        let field_owner = field_info_schema::get_owner(world,field_addr);
        let field_owner_score = player_info_schema::get_score(world,field_owner);
        player_info_schema::set_score(world,field_owner,field_owner_score+5);
        plant_schema::set(world,plant_addr,0,owner,plant_type,true);
    }

}
