module happyfarm::plant_schema {
	use std::option::some;
    use sui::tx_context::TxContext;
    use sui::table::{Self, Table};
    use happyfarm::events;
    use happyfarm::world::{Self, World};

    // Systems
	friend happyfarm::counter_system;
	friend happyfarm::player_system;
	friend happyfarm::field_system;
	friend happyfarm::plant_system;

	/// Entity does not exist
	const EEntityDoesNotExist: u64 = 0;

	const SCHEMA_ID: vector<u8> = b"plant";

	// score
	// owner
	// plant_type
	// harvested
	// plant_type_no
	struct PlantData has copy, drop , store {
		score: u64,
		owner: address,
		plant_type: address,
		harvested: bool,
		plant_type_no: u64
	}

	public fun new(score: u64, owner: address, plant_type: address, harvested: bool, plant_type_no: u64): PlantData {
		PlantData {
			score, 
			owner, 
			plant_type, 
			harvested, 
			plant_type_no
		}
	}

	public fun register(_obelisk_world: &mut World, ctx: &mut TxContext) {
		world::add_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID, table::new<address, PlantData>(ctx));
	}

	public(friend) fun set(_obelisk_world: &mut World, _obelisk_entity_key: address,  score: u64, owner: address, plant_type: address, harvested: bool, plant_type_no: u64) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID);
		let _obelisk_data = new( score, owner, plant_type, harvested, plant_type_no);
		if(table::contains<address, PlantData>(_obelisk_schema, _obelisk_entity_key)) {
			*table::borrow_mut<address, PlantData>(_obelisk_schema, _obelisk_entity_key) = _obelisk_data;
		} else {
			table::add(_obelisk_schema, _obelisk_entity_key, _obelisk_data);
		};
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), _obelisk_data)
	}

	public(friend) fun set_score(_obelisk_world: &mut World, _obelisk_entity_key: address, score: u64) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, PlantData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.score = score;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public(friend) fun set_owner(_obelisk_world: &mut World, _obelisk_entity_key: address, owner: address) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, PlantData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.owner = owner;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public(friend) fun set_plant_type(_obelisk_world: &mut World, _obelisk_entity_key: address, plant_type: address) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, PlantData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.plant_type = plant_type;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public(friend) fun set_harvested(_obelisk_world: &mut World, _obelisk_entity_key: address, harvested: bool) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, PlantData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.harvested = harvested;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public(friend) fun set_plant_type_no(_obelisk_world: &mut World, _obelisk_entity_key: address, plant_type_no: u64) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, PlantData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.plant_type_no = plant_type_no;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public fun get(_obelisk_world: &World, _obelisk_entity_key: address): (u64,address,address,bool,u64) {
		let _obelisk_schema = world::get_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlantData>(_obelisk_schema, _obelisk_entity_key);
		(
			_obelisk_data.score,
			_obelisk_data.owner,
			_obelisk_data.plant_type,
			_obelisk_data.harvested,
			_obelisk_data.plant_type_no
		)
	}

	public fun get_score(_obelisk_world: &World, _obelisk_entity_key: address): u64 {
		let _obelisk_schema = world::get_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlantData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.score
	}

	public fun get_owner(_obelisk_world: &World, _obelisk_entity_key: address): address {
		let _obelisk_schema = world::get_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlantData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.owner
	}

	public fun get_plant_type(_obelisk_world: &World, _obelisk_entity_key: address): address {
		let _obelisk_schema = world::get_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlantData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.plant_type
	}

	public fun get_harvested(_obelisk_world: &World, _obelisk_entity_key: address): bool {
		let _obelisk_schema = world::get_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlantData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.harvested
	}

	public fun get_plant_type_no(_obelisk_world: &World, _obelisk_entity_key: address): u64 {
		let _obelisk_schema = world::get_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, PlantData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.plant_type_no
	}

	public(friend) fun remove(_obelisk_world: &mut World, _obelisk_entity_key: address) {
		let _obelisk_schema = world::get_mut_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, PlantData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		table::remove(_obelisk_schema, _obelisk_entity_key);
		events::emit_remove(SCHEMA_ID, _obelisk_entity_key)
	}

	public fun contains(_obelisk_world: &World, _obelisk_entity_key: address): bool {
		let _obelisk_schema = world::get_schema<Table<address,PlantData>>(_obelisk_world, SCHEMA_ID);
		table::contains<address, PlantData>(_obelisk_schema, _obelisk_entity_key)
	}
}
