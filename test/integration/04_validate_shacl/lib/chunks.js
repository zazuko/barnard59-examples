import ToDatasetByType from 'rdf-stream-to-dataset-stream/byType.js'

export function byType (type) {
  return new ToDatasetByType(type)
}
