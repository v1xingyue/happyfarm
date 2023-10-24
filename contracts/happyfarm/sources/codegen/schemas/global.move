module happyfarm::global_schema {
	use std::option::none;
    use sui::tx_context::TxContext;
    use happyfarm::events;
    use happyfarm::world::{Self, World};
    // Systems
	friend happyfarm::counter_system;
	friend happyfarm::player_system;
	friend happyfarm::field_system;
	friend happyfarm::plant_system;

	const SCHEMA_ID: vector<u8> = b"global";

	// counter
	// admin
	// field_price
	// last_field_no
	// last_plant_no
	// init_user_socre
	struct GlobalData has copy, drop , store {
		counter: u64,
		admin: address,
		field_price: u64,
		last_field_no: u64,
		last_plant_no: u64,
		init_user_socre: u64
	}

	public fun new(counter: u64, admin: address, field_price: u64, last_field_no: u64, last_plant_no: u64, init_user_socre: u64): GlobalData {
		GlobalData {
			counter, 
			admin, 
			field_price, 
			last_field_no, 
			last_plant_no, 
			init_user_socre
		}
	}

	public fun register(_obelisk_world: &mut World, _ctx: &mut TxContext) {
		let _obelisk_schema = new(0,@0xbd2ff4ec18e5263cedda158985da65fc5324f4df81632db8f0146a1f1e41b697,10,1000,2000,200);
		world::add_schema<GlobalData>(_obelisk_world, SCHEMA_ID, _obelisk_schema);
		events::emit_set(SCHEMA_ID, none(), _obelisk_schema);
	}

	public(friend) fun set(_obelisk_world: &mut World,  counter: u64, admin: address, field_price: u64, last_field_no: u64, last_plant_no: u64, init_user_socre: u64) {
		let _obelisk_schema = world::get_mut_schema<GlobalData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.counter = counter;
		_obelisk_schema.admin = admin;
		_obelisk_schema.field_price = field_price;
		_obelisk_schema.last_field_no = last_field_no;
		_obelisk_schema.last_plant_no = last_plant_no;
		_obelisk_schema.init_user_socre = init_user_socre;
	}

	public(friend) fun set_counter(_obelisk_world: &mut World, counter: u64) {
		let _obelisk_schema = world::get_mut_schema<GlobalData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.counter = counter;
		events::emit_set(SCHEMA_ID, none(), *_obelisk_schema)
	}

	public(friend) fun set_admin(_obelisk_world: &mut World, admin: address) {
		let _obelisk_schema = world::get_mut_schema<GlobalData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.admin = admin;
		events::emit_set(SCHEMA_ID, none(), *_obelisk_schema)
	}

	public(friend) fun set_field_price(_obelisk_world: &mut World, field_price: u64) {
		let _obelisk_schema = world::get_mut_schema<GlobalData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.field_price = field_price;
		events::emit_set(SCHEMA_ID, none(), *_obelisk_schema)
	}

	public(friend) fun set_last_field_no(_obelisk_world: &mut World, last_field_no: u64) {
		let _obelisk_schema = world::get_mut_schema<GlobalData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.last_field_no = last_field_no;
		events::emit_set(SCHEMA_ID, none(), *_obelisk_schema)
	}

	public(friend) fun set_last_plant_no(_obelisk_world: &mut World, last_plant_no: u64) {
		let _obelisk_schema = world::get_mut_schema<GlobalData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.last_plant_no = last_plant_no;
		events::emit_set(SCHEMA_ID, none(), *_obelisk_schema)
	}

	public(friend) fun set_init_user_socre(_obelisk_world: &mut World, init_user_socre: u64) {
		let _obelisk_schema = world::get_mut_schema<GlobalData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.init_user_socre = init_user_socre;
		events::emit_set(SCHEMA_ID, none(), *_obelisk_schema)
	}

	public fun get(_obelisk_world: &World): (u64,address,u64,u64,u64,u64) {
		let _obelisk_schema = world::get_schema<GlobalData>(_obelisk_world, SCHEMA_ID);
		(
			_obelisk_schema.counter,
			_obelisk_schema.admin,
			_obelisk_schema.field_price,
			_obelisk_schema.last_field_no,
			_obelisk_schema.last_plant_no,
			_obelisk_schema.init_user_socre,
		)
	}

	public fun get_counter(_obelisk_world: &World): u64 {
		let _obelisk_schema = world::get_schema<GlobalData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.counter
	}

	public fun get_admin(_obelisk_world: &World): address {
		let _obelisk_schema = world::get_schema<GlobalData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.admin
	}

	public fun get_field_price(_obelisk_world: &World): u64 {
		let _obelisk_schema = world::get_schema<GlobalData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.field_price
	}

	public fun get_last_field_no(_obelisk_world: &World): u64 {
		let _obelisk_schema = world::get_schema<GlobalData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.last_field_no
	}

	public fun get_last_plant_no(_obelisk_world: &World): u64 {
		let _obelisk_schema = world::get_schema<GlobalData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.last_plant_no
	}

	public fun get_init_user_socre(_obelisk_world: &World): u64 {
		let _obelisk_schema = world::get_schema<GlobalData>(_obelisk_world, SCHEMA_ID);
		_obelisk_schema.init_user_socre
	}
}
