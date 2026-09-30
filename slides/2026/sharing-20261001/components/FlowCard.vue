<script setup lang="ts">
defineProps<{
  n?: number
  title: string
  inputs: string[]
  pre?: string
  outputs: string[]
  note: string | string[]
}>()
</script>

<template>
  <div class="flow-card">
    <div class="head">
      <span v-if="n" class="num">{{ n }}</span>
      <span class="title">{{ title }}</span>
    </div>
    <div class="flow">
      <div class="col">
        <div v-for="i in inputs" :key="i" class="chip in">{{ i }}</div>
      </div>
      <div class="arrow">→</div>
      <template v-if="pre">
        <div class="chip in">{{ pre }}</div>
        <div class="arrow">→</div>
      </template>
      <div class="chip jev">Jev</div>
      <div class="arrow">→</div>
      <div class="col">
        <div v-for="o in outputs" :key="o" class="chip out">{{ o }}</div>
      </div>
    </div>
    <div class="note">
      <div v-for="line in [note].flat()" :key="line">{{ line }}</div>
    </div>
  </div>
</template>

<style scoped>
.flow-card {
  border: 1px solid rgba(128, 128, 128, 0.35);
  border-radius: 10px;
  padding: 8px 10px;
  min-height: 190px;
  min-width: 0;
  display: flex;
  flex-direction: column;
  gap: 6px;
  font-size: 12px;
  line-height: 1.3;
}
.head { display: flex; align-items: center; justify-content: center; gap: 6px; }
.num {
  width: 18px; height: 18px; border-radius: 50%;
  border: 1px solid rgba(128, 128, 128, 0.5);
  display: inline-flex; align-items: center; justify-content: center;
  font-size: 10px; opacity: 0.7;
}
.title { font-weight: 700; font-size: 13px; }
.flow { display: flex; align-items: center; justify-content: center; gap: 3px; flex: 1; min-width: 0; }
.col { display: flex; flex-direction: column; gap: 3px; min-width: 0; }
.chip {
  border-radius: 6px; padding: 2px 6px; text-align: center; font-size: 11px;
  border: 1px solid rgba(128, 128, 128, 0.35); max-width: 7.5em; word-break: keep-all;
}
.chip.jev { white-space: nowrap; font-weight: 700; border-color: #4a9d7a; color: #4a9d7a; }
.arrow { opacity: 0.4; }
.note { opacity: 0.6; text-align: center; font-size: 11px; }
</style>
