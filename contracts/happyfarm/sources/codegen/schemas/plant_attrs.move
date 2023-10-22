module happyfarm::plant_attrs_schema {
	use std::option::some;
    use sui::tx_context::TxContext;
    use sui::table::{Self, Table};
    use happyfarm::events;
    use happyfarm::world::{Self, World};

    // Systems
	friend happyfarm::counter_system;
	friend happyfarm::player_system;

	/// Entity does not exist
	const EEntityDoesNotExist: u64 = 0;

	const SCHEMA_ID: vector<u8> = b"plant_attrs";

	// init_score
	// sun_effect
	// wind_effct
	// rain_effct
	// snow_effct
	struct PlantAttrsData has copy, drop , store {
		init_score: u64,
		sun_effect: u64,
		wind_effct: u64,
		rain_effct: u64,
		snow_effct: u64
	}

	public fun new(init_score: u64, sun_effect: u64, wind_effct: u64, rain_effct: u64, snow_effct: u64): PlantAttrsData {
		PlantAttrsData {
			init_score, 
			sun_effect, 
			wind_effct, 
			rain_effct, 
			snow_effct
		}
	}

	public fun register(_obelisk_world: &mut World, ctx: &mut TxContext) {
		world::add_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID, table::new<address, PlantAttrsData>(ctx));
	}

	public(friend) fun set(_obelisk_world: &mut World, _obelisk_entity_key: address,  init_score: u64, sun_effect: u64, wind_effct: u64, rain_effct: u64, snow_effct: u64) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID);
		let _obelisk_data = new( init_score, sun_effect, wind_effct, rain_effct, snow_effct);
		if(table::contains<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key)) {
			*table::borrow_mut<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key) = _obelisk_data;
		} else {
			table::add(_obelisk_schema, _obelisk_entity_key, _obelisk_data);
		};
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), _obelisk_data)
	}

	public(friend) fun set_init_score(_obelisk_world: &mut World, _obelisk_entity_key: address, init_score: u64) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.init_score = init_score;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public(friend) fun set_sun_effect(_obelisk_world: &mut World, _obelisk_entity_key: address, sun_effect: u64) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.sun_effect = sun_effect;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public(friend) fun set_wind_effct(_obelisk_world: &mut World, _obelisk_entity_key: address, wind_effct: u64) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.wind_effct = wind_effct;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public(friend) fun set_rain_effct(_obelisk_world: &mut World, _obelisk_entity_key: address, rain_effct: u64) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.rain_effct = rain_effct;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public(friend) fun set_snow_effct(_obelisk_world: &mut World, _obelisk_entity_key: address, snow_effct: u64) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.snow_effct = snow_effct;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public fun get(_obelisk_world: &World, _obelisk_entity_key: address): (u64,u64,u64,u64,u64) {
		let _obelisk_schema = world::get_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key);
		(
			_obelisk_data.init_score,
			_obelisk_data.sun_effect,
			_obelisk_data.wind_effct,
			_obelisk_data.rain_effct,
			_obelisk_data.snow_effct
		)
	}

	public fun get_init_score(_obelisk_world: &World, _obelisk_entity_key: address): u64 {
		let _obelisk_schema = world::get_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.init_score
	}

	public fun get_sun_effect(_obelisk_world: &World, _obelisk_entity_key: address): u64 {
		let _obelisk_schema = world::get_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.sun_effect
	}

	public fun get_wind_effct(_obelisk_world: &World, _obelisk_entity_key: address): u64 {
		let _obelisk_schema = world::get_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.wind_effct
	}

	public fun get_rain_effct(_obelisk_world: &World, _obelisk_entity_key: address): u64 {
		let _obelisk_schema = world::get_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.rain_effct
	}

	public fun get_snow_effct(_obelisk_world: &World, _obelisk_entity_key: address): u64 {
		let _obelisk_schema = world::get_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.snow_effct
	}

	public(friend) fun remove(_obelisk_world: &mut World, _obelisk_entity_key: address) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		table::remove(_obelisk_schema, _obelisk_entity_key);
		events::emit_remove(SCHEMA_ID, _obelisk_entity_key)
	}

	public fun contains(_obelisk_world: &World, _obelisk_entity_key: address): bool {
		let _obelisk_schema = world::get_schema<Table<address,PlantAttrsData>>(_obelisk_world, SCHEMA_ID);
		table::contains<address, PlantAttrsData>(_obelisk_schema, _obelisk_entity_key)
	}
}
