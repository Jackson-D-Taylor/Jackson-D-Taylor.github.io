/**
 * Explainer registry.
 *
 * A paper's frontmatter carries an `explainer:` key; the paper page template
 * looks it up here. Keeping the mapping in one file means content files stay
 * plain Markdown (no MDX, no JSX in content) and adding a paper never means
 * touching a component.
 *
 * Every explainer must:
 *   - server-render a complete, correct static SVG in its default state, so the
 *     page works with JavaScript disabled, in Reader mode, and in print;
 *   - be operable from the keyboard using native controls (<input type="range">,
 *     <button>), not custom widgets;
 *   - respect prefers-reduced-motion;
 *   - state on the page which parts are real physics and which are schematic;
 *   - ship no JavaScript at all when it does not need any.
 */

import CountTheTurns from './CountTheTurns.astro';
import TrojanLibration from './TrojanLibration.astro';
import HyperbolicFlyby from './HyperbolicFlyby.astro';
import DistanceLadder from './DistanceLadder.astro';
import RedbackOrbit from './RedbackOrbit.astro';
import ClusterCensus from './ClusterCensus.astro';

export const explainers = {
  'count-the-turns': CountTheTurns,
  'trojan-libration': TrojanLibration,
  'hyperbolic-flyby': HyperbolicFlyby,
  'distance-ladder': DistanceLadder,
  'redback-orbit': RedbackOrbit,
  'cluster-census': ClusterCensus,
} as const;

export type ExplainerKey = keyof typeof explainers;

export function getExplainer(key: string | undefined) {
  if (!key) return undefined;
  return explainers[key as ExplainerKey];
}
