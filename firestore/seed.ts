// Replaces experience_work, project_work, and profile in Firestore with firestore/seed.json.
// Dry run by default; pass --apply to write.
//   FIRESTORE_TOKEN=$(gcloud auth print-access-token) bun firestore/seed.ts --apply
import seed from "./seed.json";

const project = "portfolioweb-55f91";
const base = `https://firestore.googleapis.com/v1/projects/${project}/databases/(default)/documents`;
const apply = process.argv.includes("--apply");
const token = process.env.FIRESTORE_TOKEN;
if (!token) throw new Error("Set FIRESTORE_TOKEN (gcloud auth print-access-token)");

const headers = { Authorization: `Bearer ${token}`, "Content-Type": "application/json" };

const toValue = (v: unknown) =>
  v === null
    ? { nullValue: null }
    : typeof v === "boolean"
      ? { booleanValue: v }
      : typeof v === "number"
        ? { integerValue: String(v) }
        : { stringValue: String(v) };

async function call(method: string, url: string, body?: unknown) {
  const res = await fetch(url, { method, headers, body: body && JSON.stringify(body) });
  if (!res.ok) throw new Error(`${method} ${url}: ${res.status} ${await res.text()}`);
  return res.json();
}

for (const [collection, docs] of Object.entries(seed) as [string, Record<string, Record<string, unknown>>][]) {
  const existing: { name: string }[] = (await call("GET", `${base}/${collection}?pageSize=300`)).documents ?? [];
  const stale = existing.map((d) => d.name.split("/").pop()!).filter((id) => !(id in docs));

  console.log(`${collection}: write ${Object.keys(docs).length}, delete ${stale.length} (${stale.join(", ") || "-"})`);
  if (!apply) continue;

  for (const id of stale) await call("DELETE", `${base}/${collection}/${id}`);
  for (const [id, data] of Object.entries(docs)) {
    const fields = Object.fromEntries(Object.entries(data).map(([k, v]) => [k, toValue(v)]));
    await call("PATCH", `${base}/${collection}/${id}`, { fields });
  }
}

if (!apply) console.log("Dry run. Re-run with --apply to write.");
