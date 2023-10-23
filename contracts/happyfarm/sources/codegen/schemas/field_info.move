module happyfarm::field_info_schema {
	use std::option::some;
    use sui::tx_context::TxContext;
    use sui::table::{Self, Table};
    use happyfarm::events;
    use happyfarm::world::{Self, World};

    // Systems
	friend happyfarm::counter_system;
	friend happyfarm::player_system;
	friend happyfarm::field_system;

	/// Entity does not exist
	const EEntityDoesNotExist: u64 = 0;

	const SCHEMA_ID: vector<u8> = b"field_info";

	// owner
	// filed_no
	struct FieldInfoData has copy, drop , store {
		owner: address,
		filed_no: u64
	}

	public fun new(owner: address, filed_no: u64): FieldInfoData {
		FieldInfoData {
			owner, 
			filed_no
		}
	}

	public fun register(_obelisk_world: &mut World, ctx: &mut TxContext) {
		world::add_schema<Table<address,FieldInfoData>>(_obelisk_world, SCHEMA_ID, table::new<address, FieldInfoData>(ctx));
	}

	public(friend) fun set(_obelisk_world: &mut World, _obelisk_entity_key: address,  owner: address, filed_no: u64) {
		let _obelisk_schema = world::get_mut_schema<Table<address,FieldInfoData>>(_obelisk_world, SCHEMA_ID);
		let _obelisk_data = new( owner, filed_no);
		if(table::contains<address, FieldInfoData>(_obelisk_schema, _obelisk_entity_key)) {
			*table::borrow_mut<address, FieldInfoData>(_obelisk_schema, _obelisk_entity_key) = _obelisk_data;
		} else {
			table::add(_obelisk_schema, _obelisk_entity_key, _obelisk_data);
		};
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), _obelisk_data)
	}

	public(friend) fun set_owner(_obelisk_world: &mut World, _obelisk_entity_key: address, owner: address) {
		let _obelisk_schema = world::get_mut_schema<Table<address,FieldInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, FieldInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, FieldInfoData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.owner = owner;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public(friend) fun set_filed_no(_obelisk_world: &mut World, _obelisk_entity_key: address, filed_no: u64) {
		let _obelisk_schema = world::get_mut_schema<Table<address,FieldInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, FieldInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow_mut<address, FieldInfoData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.filed_no = filed_no;
		events::emit_set(SCHEMA_ID, some(_obelisk_entity_key), *_obelisk_data)
	}

	public fun get(_obelisk_world: &World, _obelisk_entity_key: address): (address,u64) {
		let _obelisk_schema = world::get_schema<Table<address,FieldInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, FieldInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, FieldInfoData>(_obelisk_schema, _obelisk_entity_key);
		(
			_obelisk_data.owner,
			_obelisk_data.filed_no
		)
	}

	public fun get_owner(_obelisk_world: &World, _obelisk_entity_key: address): address {
		let _obelisk_schema = world::get_schema<Table<address,FieldInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, FieldInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, FieldInfoData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.owner
	}

	public fun get_filed_no(_obelisk_world: &World, _obelisk_entity_key: address): u64 {
		let _obelisk_schema = world::get_schema<Table<address,FieldInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, FieldInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		let _obelisk_data = table::borrow<address, FieldInfoData>(_obelisk_schema, _obelisk_entity_key);
		_obelisk_data.filed_no
	}

	public(friend) fun remove(_obelisk_world: &mut World, _obelisk_entity_key: address) {
		let _obelisk_schema = world::get_mut_schema<Table<address,FieldInfoData>>(_obelisk_world, SCHEMA_ID);
		assert!(table::contains<address, FieldInfoData>(_obelisk_schema, _obelisk_entity_key), EEntityDoesNotExist);
		table::remove(_obelisk_schema, _obelisk_entity_key);
		events::emit_remove(SCHEMA_ID, _obelisk_entity_key)
	}

	public fun contains(_obelisk_world: &World, _obelisk_entity_key: address): bool {
		let _obelisk_schema = world::get_schema<Table<address,FieldInfoData>>(_obelisk_world, SCHEMA_ID);
		table::contains<address, FieldInfoData>(_obelisk_schema, _obelisk_entity_key)
	}
}
