import './Model.dart';
import './ItemCreatorType.dart';
import './AbstractCollectionManager.dart';
import 'dart:mirrors';
import './AjaxDriver.dart';

class RelatedCollectionManager <T extends Model, P extends Model> extends AbstractCollectionManager<T> {
  int? parent_id;
  String? parent_key;
  String? parent_model_name;
  ItemCreator<T> creator;
  
  RelatedCollectionManager(ItemCreator<T> this.creator, P parent, String this.parent_key) {
    this.parent_id = parent.id;
    InstanceMirror parent_mirror = reflect(parent);
    this.parent_model_name = parent_mirror.type.reflectedType.toString().toLowerCase();
  }

  String get collection_url {
    return '/${this.parent_model_name}/${this.parent_id}/${this.parent_key}';
  }

  Future add_ids(List<int> ids) async {
    return httpDriverImpl.request_void('POST', this.collection_url, ids);
  }

  Future set_ids(List<int> ids) async {
    return httpDriverImpl.request_void('PUT', this.collection_url, ids);
  }

  Future remove_ids(List<int> ids) async {
    return httpDriverImpl.request_void('DELETE', this.collection_url, ids);
  }

  Future add (List<T> objects) async {
    return httpDriverImpl.request_void('POST', this.collection_url, objects.map((val) => val.id).toList());
  }

  Future set (List<T> objects) async {
    return httpDriverImpl.request_void('PUT', this.collection_url, objects.map((val) => val.id).toList());
  }

  Future remove(List<T> objects) async {
    return httpDriverImpl.request_void('DELETE', this.collection_url, objects.map((val) => val.id).toList());
  }
}